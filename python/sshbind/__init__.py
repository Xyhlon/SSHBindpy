# from ._lib_name import bind, unbind
from ._lib_sshbind_wrapper import bind as _bind, unbind as _unbind
from typing import List

from contextlib import (
    AbstractContextManager as _AbstractContextManager,
    ContextDecorator as _ContextDecorator,
)


class SSHBinding(_AbstractContextManager, _ContextDecorator):
    """
    A context manager that binds a connection upon entering the context
    and ensures unbinding upon exit.
    """

    def __init__(
        self, addr: str, jump_hosts: List[str], remote_addr: str, sopsfile: str
    ):
        self.addr = addr
        self.jump_hosts = jump_hosts
        self.remote_addr = remote_addr
        self.sopsfile = sopsfile
        self.bound = False

    def __enter__(self):
        # Call the Rust function to bind the connection.
        _bind(self.addr, self.jump_hosts, self.remote_addr, self.sopsfile)
        self.bound = True
        return self

    def __exit__(self, exc_type, exc_value, traceback):
        if self.bound:
            _unbind(self.addr)
        return False


# Export only the context manager
__all__ = ["SSHBinding"]
