
@REM set TRAPPER_DIR=%CD%

rmdir /S /Q build
rmdir /S /Q -rf .mycache
rmdir /S /Q -rf mybuild
rmdir /S /Q -rf myprebuilt
rmdir /S /Q -rf mythirdparty

@REM Build default examples

call .\scripts\examples\default\mmg\build.bat
@REM call build_embree.bat
@REM call build_dlib.bat
@REM call build_polyscope.bat

@REM Build advanced examples

@REM call .\scripts\examples\advanced\mmg\build.bat
@REM call build_embree.bat
@REM call build_dlib.bat
@REM call build_polyscope.bat
