import hashlib

#Algoritmos disponibles, se pueden añadir más
ALGORITMOS = ['md5', 'sha1', 'sha256']

def generar_hash(texto: str, algoritmo: str) -> str:
    hash_func = hashlib.new(algoritmo)
    hash_func.update(texto.encode('utf-8'))
    return hash_func.hexdigest()

def seleccionar_algoritmo() -> str:
    max_opcion = len(ALGORITMOS) - 1

    print("\nSelecciona el algoritmo de hash:")
    for k, num in enumerate(ALGORITMOS):
        print(f"{k} - {num}")

    while True:
        try:
            opcion = int(input(f"Opcion (0-{max_opcion}): "))
            if 0 <= opcion <= max_opcion:
                return ALGORITMOS[opcion]
            else:
                print("Número fuera de rango. Intenta de nuevo")
        except ValueError:
            print("Entrada inválida. Ingresa un número.")


def preguntar_repetir() -> bool:
    while True:
        print("\n¿Qué quieres hacer ahora?")
        print("0 - Hashear otro mensaje")
        print("1 - Salir")
        opcion = input("Opción (0-1): ").strip()
        if opcion == "0":
            return True
        elif opcion == "1":
            return False
        else:
            print("Opción inválida. Ingresa 0 o 1.")

def main ():
    print("=== Generador de Hash con Menú ===")
    repetir = True
    while repetir:
        mensaje = input("\nIngresa el mensaje a hashear: ")
        algoritmo = seleccionar_algoritmo()
        hash_result = generar_hash(mensaje, algoritmo)
        print(f"\nHash ({algoritmo}): {hash_result}")
        repetir = preguntar_repetir()

    print("\n ¡Gracias por usar mi aplicación!")

if __name__ == "__main__":
    main()
    