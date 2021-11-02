del /S /Q build

cmake -S . -B build -G Ninja ^
-DCMAKE_BUILD_TYPE=Release ^
-DCMAKE_WINDOWS_EXPORT_ALL_SYMBOLS=TRUE ^
-DCMAKE_INSTALL_PREFIX=".\prebuilt"
@REM -DIMGUI_WITH_IMPL=ON ^
@REM -DIMGUI_IMPL_GLFW3_OPENGL3=ON

cmake --build build

cmake --build build --target install
