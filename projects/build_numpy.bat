set PY=%1

cd

%PY% -c "import os; print(os.getcwd())"

%PY% -m pip install -r requirements.txt

if not exist numpy git clone https://github.com/numpy/numpy.git

pushd numpy
git reset --hard
git checkout v1.11.3

git apply %2

%PY% ..\build_numpy.py
