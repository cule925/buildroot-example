try:
    from lxml import etree
except ImportError as e:
    # If libraries are not present
    print("Failed to import lxml - required libraries may be missing!")
    print(e)
    exit(1)

def main():
    # Simple XML parsing to verify functionality
    xml_content = "<root><child>Hello Buildroot</child></root>"

    try:
        root = etree.fromstring(xml_content)
        child = root.find("child")
        print("XML parsed successfully. Child text:", child.text)
    except Exception as e:
        print("XML parsing failed:", e)
        exit(1)

if __name__ == "__main__":
    main()
