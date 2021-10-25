
@REM set TRAPPER_DIR=%CD%

rmdir /S /Q build
rmdir /S /Q -rf .mycache
rmdir /S /Q -rf mybuild
rmdir /S /Q -rf myprebuilt
rmdir /S /Q -rf mythirdparty

rmdir /S /Q -rf .cache
rmdir /S /Q -rf build
rmdir /S /Q -rf prebuilt
rmdir /S /Q -rf thirdparty

@REM Build default examples

call .\examples\default\mmg\build.bat
@REM call build_embree.bat
@REM call build_dlib.bat
@REM call build_polyscope.bat

@REM Build advanced examples

@REM call .\scripts\examples\advanced\mmg\build.bat
@REM call build_embree.bat
@REM call build_dlib.bat
@REM call build_polyscope.bat
