import subprocess
import pytest
import paquete_minimo.main as paq



def test_first_number(first)-> None:
    rc = subprocess.run(args= [f"multi -m 2"], shell=True)
    assert rc == 0
                               
@pytest.mark.parametrize("option", "number", [( "-p", 5), ("-o", 7)])
def test_remain_numbers(option, number) -> None:
    rc = subprocess.run(args= [f"multi -m 2 {option} {number}"])
    assert rc == 0

