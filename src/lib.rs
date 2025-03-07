use pyo3::prelude::*;
use sshbind::{bind as rs_bind, unbind as rs_unbind};

#[pyfunction]
fn bind(addr: &str, jump_hosts: Vec<String>, remote_addr: &str, sopsfile: &str) -> PyResult<()> {
    rs_bind(addr, jump_hosts, remote_addr, sopsfile);
    Ok(())
}

#[pyfunction]
fn unbind(addr: &str) -> PyResult<()> {
    rs_unbind(addr);
    Ok(())
}

/// A Python module implemented in Rust.
#[pymodule]
#[pyo3(name = "_lib_sshbind_wrapper")]
fn wrapper_module(m: &Bound<'_, PyModule>) -> PyResult<()> {
    m.add_function(wrap_pyfunction!(bind, m)?)?;
    m.add_function(wrap_pyfunction!(unbind, m)?)?;
    Ok(())
}
