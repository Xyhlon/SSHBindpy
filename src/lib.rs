use env_logger::Builder;
use log::LevelFilter;
use pyo3::prelude::*;
use sshbind::{bind as rs_bind, unbind as rs_unbind};
use std::io::Write;
use std::sync::LazyLock;

static LOGGER: LazyLock<()> = LazyLock::new(|| {
    Builder::new()
        .filter(None, LevelFilter::Info) // Adjust log level as needed
        .format(|buf, record| writeln!(buf, "[{}] - {}", record.level(), record.args()))
        .init();
});

#[pyfunction]
fn bind(
    addr: &str,
    jump_hosts: Vec<String>,
    remote_addr: &str,
    sopsfile: &str,
    debug: bool,
) -> PyResult<()> {
    if debug {
        #[allow(clippy::let_unit_value)]
        let _ = *LOGGER; // Ensure logger is initialized
    }
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
