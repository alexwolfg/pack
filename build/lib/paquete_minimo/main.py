#Coge numero por CLI como argumentos y los multiplica, mostrandolo por pantalla
import argparse
def main()-> None:

    parser = argparse.ArgumentParser()

    #Argumentos obligatorios
    group = parser.add_mutually_exclusive_group(required=True)

    #Para los argumentos que necesitan input del usuario, no se utiliza el action="store_true". Son opciones obligatorias,
    #pero no las dos a la vez
    group.add_argument("-m", "--multiplicator", type=int, help="First value")
    #group.add_argument("-p", "--pair", type=int, help="Second value")

    parser.add_argument("-p", "--pair", type=int, default=1, help="Second value")
    parser.add_argument("-o", "--over-two", type=int, default=1, help="Additional arguments")
    parser.add_argument("-v", "--verbose", help="increase output verbosity", action="store_true")

    args = parser.parse_args()

    print(f'#####Resultado {args.multiplicator*args.pair*args.over_two}#######')
    

if __name__ == "__main__":
    main()