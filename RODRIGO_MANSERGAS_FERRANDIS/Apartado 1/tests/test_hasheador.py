import hashlib
import pytest
import sys
import os

sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

from Hasheador import generar_hash, seleccionar_algoritmo, preguntar_repetir, ALGORITMOS

def test_generar_hash_sha256():
    texto = "hola"
    algoritmo = "sha256"
    esperado = hashlib.sha256(texto.encode()).hexdigest()
    assert generar_hash(texto, algoritmo) == esperado

def test_generar_hash_md5():
    texto = "adios"
    algoritmo = "md5"
    esperado = hashlib.md5(texto.encode()).hexdigest()
    assert generar_hash(texto, algoritmo) == esperado

def test_seleccionar_algoritmo_sha1(monkeypatch):
    inputs = iter(["1"])
    monkeypatch.setattr("builtins.input", lambda _: next(inputs))

    seleccionado = seleccionar_algoritmo()
    assert seleccionado == ALGORITMOS[1]

def test_seleccionar_algoritmo_con_errores(monkeypatch, capsys):
    inputs = iter(["abc", "9", "0"])
    monkeypatch.setattr("builtins.input", lambda _: next(inputs))

    seleccion = seleccionar_algoritmo()
    assert seleccion == ALGORITMOS[0]

    salida = capsys.readouterr().out
    assert "Entrada inválida" in salida
    assert "Número fuera de rango" in salida

def test_preguntar_repetir_si(monkeypatch):
    monkeypatch.setattr("builtins.input", lambda _: "0")
    assert preguntar_repetir() is True

def test_preguntar_repetir_no(monkeypatch):
    monkeypatch.setattr("builtins.input", lambda _: "1")
    assert preguntar_repetir() is False

def test_preguntar_repetir_invalidado(monkeypatch, capsys):
    inputs = iter(["x", "5", "0"])
    monkeypatch.setattr("builtins.input", lambda _: next(inputs))

    resultado = preguntar_repetir()
    assert resultado is True

    salida = capsys.readouterr().out
    assert "Opción inválida" in salida

    """poner que se tiene que instalar pip install pytest y sudo apt install python3-pytest"""