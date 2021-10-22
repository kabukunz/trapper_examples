
del /S /Q .\build\CMakeCache.txt

cmake -B build -G Ninja ^
-DTRAPPER_BUILD_ADVANCED_EXAMPLES=ON ^
-DTRAPPER_BUILD_MMG_EXAMPLE=ON ^
-DCMAKE_BUILD_TYPE=Debug ^
-DUSE_SCOTCH=ON 

cmake --build build


