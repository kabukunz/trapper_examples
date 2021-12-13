
@REM set TRAPPER_DIR=%CD%

@REM rmdir /S /Q build
@REM rmdir /S /Q -rf .mycache
@REM rmdir /S /Q -rf mybuild
@REM rmdir /S /Q -rf myprebuilt
@REM rmdir /S /Q -rf mythirdparty

@REM rmdir /S /Q -rf .cache
@REM rmdir /S /Q -rf build
@REM rmdir /S /Q -rf prebuilt
@REM rmdir /S /Q -rf thirdparty

@REM Build default examples

@REM call .\examples\default\mmg\build.bat
@REM call build_embree.bat
@REM call build_dlib.bat
@REM call build_polyscope.bat
@REM .\examples\default\imgui\build.bat
.\examples\default\pybind11\build.bat

@REM Build advanced examples

@REM call .\scripts\examples\advanced\mmg\build.bat
@REM call build_embree.bat
@REM call build_dlib.bat
@REM call build_polyscope.bat
