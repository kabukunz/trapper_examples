
@REM set TRAPPER_DIR=%CD%

rmdir /S /Q -rf .cache
rmdir /S /Q -rf build
rmdir /S /Q -rf prebuilt
rmdir /S /Q -rf external

@REM Build default examples

@REM .\examples\default\mmg\build.bat
@REM call build_embree.bat
@REM call build_dlib.bat
@REM call build_polyscope.bat
@REM .\examples\default\imgui\build.bat
@REM .\examples\default\pybind11\build.bat
@REM .\examples\default\nanoflann\build.bat
.\examples\default\libzippp\build.bat

@REM Build advanced examples

@REM call .\scripts\examples\advanced\mmg\build.bat
@REM call build_embree.bat
@REM call build_dlib.bat
@REM call build_polyscope.bat
