## Python ##

#### [Module](https://docs.python.org/3/tutorial/modules.html) ####

> A module is a file containing Python definitions and statements.  

> The file name is the module name with the suffix .py appended.

> when import a module, it will import all names except those beginning with an underscore (\_).  

**__name__**  
`__name__` is a special value that recall a module whether exec immediately.  

for example,  
> if `test.py` exec immediately, `__name__`'s value in `test.py` would be `__main__`  

> elif `test.py` was imported, `__name__`'s value in `test.py` would be module's name.  

#### Packages ####

> a way of structuring Python's module namespace by using "dotted module names"  
for example,  
module name A.B designates a submodule named B in a package named A.  

**__init__.py**  
> It is *required* to make Python treat the directories as containing packages  
> If it is an empty file, then import all modules in package.  
(also can import specify modules) 

**__all__**  
> It is a value that recall imported modules by list.  


