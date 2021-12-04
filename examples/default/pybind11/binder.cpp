#include <pybind11/pybind11.h>
// #include <pybind11/stl.h>
// #include <pybind11/stl_bind.h>
// #include <pybind11/eigen.h>

namespace py = pybind11;

PYBIND11_MODULE(binder, m)
{
    m.doc() = "binder";

    py::class_<MyClass, std::shared_ptr<MyClass>>(m, "MyClass")
        .def(py::init<>())
        .def("Run", &MyClass::Run)
        .def_readwrite("runmsg", &MyClass::runmsg);

	m.def("main", [](std::vector<std::string> args) {
		std::vector<char *> cstrs;
		cstrs.reserve(args.size());
		for (auto &s : args)
			cstrs.push_back(const_cast<char *>(s.c_str()));
		return main(cstrs.size(), cstrs.data());
	});

}
