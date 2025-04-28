# from ._lib_name import bind, unbind
from contextlib import AbstractContextManager as _AbstractContextManager
from contextlib import ContextDecorator as _ContextDecorator
from typing import List as _List

from ._lib_sshbind_wrapper import bind as _bind
from ._lib_sshbind_wrapper import unbind as _unbind


class SSHBinding(_AbstractContextManager, _ContextDecorator):
    """
    A context manager that binds a connection upon entering the context
    and ensures unbinding upon exit.
    """

    def __init__(
        self,
        addr: str,
        jump_hosts: _List[str],
        sopsfile: str,
        remote_addr: str | None = None,
        cmd: str | None = None,
        debug: str | None = False,
    ):
        self.addr = addr
        self.jump_hosts = jump_hosts
        self.remote_addr = remote_addr
        self.sopsfile = sopsfile
        self.bound = False
        self.debug = debug
        self.cmd = cmd

    def __enter__(self):
        # Call the Rust function to bind the connection.
        _bind(
            addr=self.addr,
            jump_hosts=self.jump_hosts,
            sopsfile=self.sopsfile,
            remote_addr=self.remote_addr,
            cmd=self.cmd,
            debug=self.debug,
        )
        self.bound = True
        return self

    def __exit__(self, exc_type, exc_value, traceback):
        if self.bound:
            _unbind(self.addr)
        return False


# Export only the context manager
__all__ = ["SSHBinding"]
