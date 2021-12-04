#include <pybind11/pybind11.h>
#include <pybind11/stl.h>

#include "runner.hpp"

namespace py = pybind11;

PYBIND11_MODULE(binder, m)
{
    m.doc() = "binder";

    py::class_<Runner, std::shared_ptr<Runner>>(m, "Runner")
        .def(py::init<>())
        .def("Run", &Runner::Run)
        .def_readwrite("msg", &Runner::msg);

	m.def("main", [](std::vector<std::string> args) {
		std::vector<char *> cstrs;
		cstrs.reserve(args.size());
		for (auto &s : args)
			cstrs.push_back(const_cast<char *>(s.c_str()));
		return main(cstrs.size(), cstrs.data());
	});

}
