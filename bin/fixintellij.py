#! /usr/bin/env python

import os.path
import lxml.etree

etree = lxml.etree


def main():
    for root, dirs, files in os.walk(os.path.curdir):
        for imlfile in files:
            if imlfile.endswith(".iml"):
                iml_filename = os.path.join(root, imlfile)
                tree = etree.parse(iml_filename)
                output = tree.find("//output")
                found = False
                if output is not None:
                    if output.get('url') != 'file://$MODULE_DIR$/target/classes':
                        output.set('url', 'file://$MODULE_DIR$/target/classes')
                        found = True
                output_test = tree.find("//output-test")
                if output_test is not None:
                    if output_test.get('url') != 'file://$MODULE_DIR$/target/test-classes':
                        output_test.set('url', 'file://$MODULE_DIR$/target/test-classes')
                        found = True
                if found:
                    print "fixing " + iml_filename
                    tree.write(iml_filename)


if __name__ == "__main__":
    main()
