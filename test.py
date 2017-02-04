import sys

def main():
    print "I WORKED!"
    print 'Number of arguments:', len(sys.argv), 'arguments.'
    print 'Argument List:', str(sys.argv)
    with open("/home/dk503/proj/test.txt", "wb") as f:
        f.write("Blah blah blah.")

if __name__ == "__main__":
    main()
