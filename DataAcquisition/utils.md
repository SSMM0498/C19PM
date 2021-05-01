# create a virtual environment
`python -m venv env`

# active the virtual environment
### Linux
`source env/bin/activate`
### Windows
`env\Scripts\activate`

# create the requirement.txt
`pip freeze > requirement.txt`

# deactivate the virtual environment 
`deactivate`

# install requirement
`pip install -r requirement.txt`

# List packages
`pip list`