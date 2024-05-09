To get State varible - 
forge inspect src/ocean/ocean.sol:Ocean storgae --pretty
forge inspect Path=>(src/ocean/ocean.sol:Ocean=> contract Name) storgae --pretty

To get the methods/Functions - 
forge inspect src/ocean/ocean.sol:Ocean methods --pretty

To Get the abi/ IT will create an Interface for that contract
forge inspect src/ocean/ocean.sol:Ocean abi --pretty > temp.sol