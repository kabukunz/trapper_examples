
@REM del /S /Q .\build\CMakeCache.txt

cmake -S . -B build -G Ninja ^
-DCMAKE_WINDOWS_EXPORT_ALL_SYMBOLS=TRUE ^
-DCMAKE_BUILD_TYPE=Release ^
 ^
-DTRAPPER_BUILD_DEFAULT_EXAMPLES=OFF ^
-DTRAPPER_BUILD_ADVANCED_EXAMPLES=OFF ^
-DTRAPPER_BUILD_MMG_EXAMPLE=OFF ^
-DTRAPPER_BUILD_EMBREE_EXAMPLE=OFF ^
-DTRAPPER_BUILD_DLIB_EXAMPLE=OFF ^
-DTRAPPER_BUILD_POLYSCOPE_EXAMPLE=OFF ^
-DTRAPPER_BUILD_IMGUI_EXAMPLE=OFF ^
-DTRAPPER_BUILD_NANOFLANN_EXAMPLE=OFF ^
-DTRAPPER_BUILD_LIBZIPPP_EXAMPLE=OFF ^
 ^
-DTRAPPER_BUILD_DEFAULT_EXAMPLES=ON ^
-DTRAPPER_BUILD_LIBZIPPP_EXAMPLE=ON

cmake --build build
