#!/usr/bin/env python3
# BlueZ pairing agent for the Bluetooth popup (Quickshell has none).
# Requests go to stdout as JSON lines; the answer to a question comes back on stdin as "yes" or "no".
import json
import random
import sys

import dbus
import dbus.service
from dbus.mainloop.glib import DBusGMainLoop
from gi.repository import GLib

AGENT = "org.bluez.Agent1"
PATH = "/org/dotfiles/bluetooth_agent"


class Rejected(dbus.DBusException):
    _dbus_error_name = "org.bluez.Error.Rejected"


class Agent(dbus.service.Object):
    pending = None

    def send(self, kind, device=None, code=None):
        message = {"kind": kind}
        if device:
            props = bus.get_object("org.bluez", device).GetAll(
                "org.bluez.Device1", dbus_interface="org.freedesktop.DBus.Properties"
            )
            message |= {"address": str(props["Address"]), "name": str(props["Alias"]), "code": code}
        print(json.dumps(message), flush=True)

    def ask(self, kind, device, code, reply, error):
        if self.pending:
            self.pending[1](Rejected("Superseded"))
        self.pending = (reply, error)
        self.send(kind, device, code)

    def answer(self, line):
        if self.pending:
            reply, error = self.pending
            self.pending = None
            reply() if line == "yes" else error(Rejected("Rejected by user"))

    @dbus.service.method(AGENT)
    def Release(self):
        pass

    # Legacy keyboards: we choose the PIN and the user types it on the keyboard.
    @dbus.service.method(AGENT, in_signature="o", out_signature="s")
    def RequestPinCode(self, device):
        pin = f"{random.randrange(10**6):06d}"
        self.send("type", device, pin)
        return pin

    @dbus.service.method(AGENT, in_signature="os")
    def DisplayPinCode(self, device, pin):
        self.send("type", device, str(pin))

    @dbus.service.method(AGENT, in_signature="o", out_signature="u")
    def RequestPasskey(self, device):
        raise Rejected("Entering a passkey shown by the device is not supported")

    @dbus.service.method(AGENT, in_signature="ouq")
    def DisplayPasskey(self, device, passkey, entered):
        self.send("type", device, f"{passkey:06d}")

    @dbus.service.method(AGENT, in_signature="ou", async_callbacks=("reply", "error"))
    def RequestConfirmation(self, device, passkey, reply, error):
        self.ask("confirm", device, f"{passkey:06d}", reply, error)

    @dbus.service.method(AGENT, in_signature="o", async_callbacks=("reply", "error"))
    def RequestAuthorization(self, device, reply, error):
        self.ask("authorize", device, None, reply, error)

    @dbus.service.method(AGENT, in_signature="os", async_callbacks=("reply", "error"))
    def AuthorizeService(self, device, uuid, reply, error):
        self.ask("authorize", device, None, reply, error)

    @dbus.service.method(AGENT)
    def Cancel(self):
        self.pending = None
        self.send("cancel")


def register(owner):
    # Also called when bluetoothd (re)starts, which drops every registered agent.
    if owner:
        manager = dbus.Interface(bus.get_object("org.bluez", "/org/bluez"), "org.bluez.AgentManager1")
        manager.RegisterAgent(PATH, "KeyboardDisplay")
        manager.RequestDefaultAgent(PATH)


def read_answer(source, condition):
    line = sys.stdin.readline()
    if not line:
        loop.quit()
        return False
    agent.answer(line.strip())
    return True


DBusGMainLoop(set_as_default=True)
bus = dbus.SystemBus()
agent = Agent(bus, PATH)
bus.watch_name_owner("org.bluez", register)
loop = GLib.MainLoop()
GLib.io_add_watch(sys.stdin, GLib.IO_IN | GLib.IO_HUP, read_answer)
loop.run()
