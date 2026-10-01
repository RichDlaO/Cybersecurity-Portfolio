# Algorithm for file updates in Python

## Project description
At my organization, access to restricted content is controlled through an IP address allow list specified in the `allow_list.txt` file. A separate remove list identifies IP addresses that should no longer have access. I developed an automated Python algorithm to parse `allow_list.txt`, cross-reference it with the remove list, and rewrite the file with only authorized IP addresses. This script ensures network security controls remain accurate and up to date without requiring manual entry updates.

---

## Open the file that contains the allow list
To begin processing the allow list, I assigned the filename to the `import_file` variable. I then used a `with` statement and the `open()` function in read mode (`"r"`) to safely open the file and handle automatic resource cleanup:

```python
import_file = "allow_list.txt"

with open(import_file, "r") as file:
```

---

## Read the file contents
Inside the `with` block, I utilized the `.read()` method to extract the text content from `allow_list.txt` and store it in the `ip_addresses` variable as a single string:

```python
    ip_addresses = file.read()
```

---

## Convert the string into a list
Since `.read()` imports file contents as a single string, I applied the `.split()` method to convert `ip_addresses` into a list of individual IP address strings, making it possible to inspect and remove specific entries:

```python
ip_addresses = ip_addresses.split()
```

---

## Iterate through the remove list
I set up a `for` loop to iterate through every IP address stored in the `remove_list` using `element` as the loop variable:

```python
for element in remove_list:
```

---

## Remove IP addresses that are on the remove list
Within the loop, I evaluated whether each IP address from `remove_list` existed in `ip_addresses` using a conditional `if` statement. If present, I invoked the `.remove()` method to eliminate the address from the allow list:

```python
    if element in ip_addresses:
        ip_addresses.remove(element)
```

---

## Update the file with the revised list of IP addresses
To write the modified list back to `allow_list.txt`, I first converted `ip_addresses` back into a newline-separated string using `\n.join()` and assigned it to `ip_addresses_str`. Then, I opened `import_file` in write mode (`"w"`) using a `with` statement and applied `.write()` to overwrite the file with the updated string:

```python
ip_addresses_str = "\n".join(ip_addresses)

with open(import_file, "w") as file:
    file.write(ip_addresses_str)
```

---

## Summary
I created an automated Python algorithm that opens and reads an access control file (`allow_list.txt`), converts its content into a manageable list, and cross-references it with a removal list. Using iterative loops and conditional logic, the algorithm filters out unauthorized IP addresses and rewrites the updated list back to the text file. This script streamlines security access maintenance, reduces human error in file updates, and automates IP authorization workflows.