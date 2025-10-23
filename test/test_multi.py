import subprocess
import pytest
import sys

sys.path.insert(0, "../paquete_minimo")

from paquete_minimo.main import main

@pytest.mark.parametrize("option", "number", [( "-m", "2")])
def test_first_number(option,number)-> None:
    rc = subprocess.run(args= [f"multi {option} {number}"], shell=True)
    assert rc == 0
                               
@pytest.mark.parametrize("option", "number", [( "-p", "5"), ("-o", "7")])
def test_remain_numbers(option, number) -> None:
    rc = subprocess.run(args= [f"multi -m 2 {option} {number}"])
    assert rc == 0

