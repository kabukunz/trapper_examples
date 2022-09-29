
del /S /Q .\build\CMakeCache.txt

set TRAPPER_DIR=%CD%
set PYTHON37=%TRAPPER_DIR%\external\python3.7.0
set PYTHON_EXECUTABLE=%PYTHON37%\python.exe

curl -LO https://gitlab.com/libeigen/eigen/-/archive/3.3.9/eigen-3.3.9.zip
powershell -command "Expand-Archive eigen-3.3.9.zip external"

@REM curl -LO https://www.python.org/ftp/python/3.7.0/python-3.7.0-embed-amd64.zip
@REM powershell -command "Expand-Archive python-3.7.0-embed-amd64.zip %PYTHON37%"

@REM set PYTHON37=%LOCALAPPDATA%\Programs\Python\Python37

cmake -B build -G "Ninja" ^
-DCMAKE_WINDOWS_EXPORT_ALL_SYMBOLS=TRUE ^
-DCMAKE_BUILD_TYPE=RELEASE ^
-DTRAPPER_BUILD_DEFAULT_EXAMPLES=OFF ^
-DTRAPPER_BUILD_ADVANCED_EXAMPLES=OFF ^
 ^
-DTRAPPER_BUILD_MMG_EXAMPLE=OFF ^
-DTRAPPER_BUILD_EMBREE_EXAMPLE=OFF ^
-DTRAPPER_BUILD_DLIB_EXAMPLE=OFF ^
-DTRAPPER_BUILD_POLYSCOPE_EXAMPLE=OFF ^
-DTRAPPER_BUILD_IMGUI_EXAMPLE=OFF ^
-DTRAPPER_BUILD_PYBIND11_EXAMPLE=OFF ^
 ^
-DTRAPPER_BUILD_DEFAULT_EXAMPLES=ON ^
-DTRAPPER_BUILD_PYBIND11_EXAMPLE=ON ^
 ^
-DPYBIND11_INSTALL=ON ^
-DPYBIND11_TEST=OFF ^
-DDOWNLOAD_EIGEN=OFF ^
-DEigen3_DIR="external\eigen-3.3.9" ^
-DPYTHON_EXECUTABLE=%PYTHON_EXECUTABLE%

cmake --build build

%PYTHON_EXECUTABLE% %cd%\examples\default\pybind11\run.py
%PYTHON_EXECUTABLE% %cd%\examples\default\pybind11\main.py

@REM TODO: download eigen
@REM TODO: download python37
