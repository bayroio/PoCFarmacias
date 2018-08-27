/*
* Author: Edgar Herrador
* Date: August 19, 2018
* Version: 0.5
*/

pragma solidity ^0.4.24;

contract PoCFarmacias {
    struct Medicina {
        uint id;
        uint precio;
        uint existencia;
        bool borrado;
    }
    
    address owner;
    
    Medicina[] public medicamentos;
    
    event ThrowError (string message);
    
    modifier onlyOwner { 
        if (msg.sender == owner) 
            _; 
        else
            emit ThrowError ("You does not permissions to execute this service");
    }
    
    constructor () public {
        owner = msg.sender;
    }
    
    /*
    Crea una nueva Medicina
    */
    function nuevoMedicamento (uint _id, uint _precio, uint _existencia) onlyOwner public returns (bool success) {
        require(_id > 0, "Debes indicar el id único de la medicina");
        require(_precio > 0, "Debes indicar el precio de la medicina");
        require(_existencia > 0, "Debes indicar la existencia inicial de la medicina");
        
        medicamentos.push(Medicina({id:_id, precio: _precio, existencia: _existencia, borrado: false}));
        
        return true;
    }
    
    /*
    Modifica la existencia de una Medicina
    */
    function modificaExistencia (uint _id, uint _existencia) onlyOwner public returns (bool success) {
        require(_id > 0, "Debes indicar el id único de la medicina");
        require(_existencia > 0, "Debes indicar la existencia inicial de la medicina");

        medicamentos[_id-1].existencia = medicamentos[_id-1].existencia + _existencia;
        
        return true;
    }
    
    /*
    Modifica el precio de una Medicina
    */
    function modificaPrecio (uint _id, uint _precio) onlyOwner public returns (bool success) {
        require(_id > 0, "Debes indicar el id único de la medicina");
        require(_precio > 0, "Debes indicar la existencia inicial de la medicina");
        
        uint i = _id-1;
        medicamentos[i].precio = _precio;
        
        return true;
    }
    
    /*
    Obten una Medicina
    */
    function getMedicamento (uint _id) onlyOwner public returns (uint _idMedicamento, uint _precio, uint _existencia) {
        require(_id > 0, "Debes indicar el id único de la medicina");

        uint i = _id-1;
        return (medicamentos[i].id, medicamentos[i].precio, medicamentos[i].existencia);
    }
    
    /*
    Remueve una Medicina
    */
    function eliminaMedicamento (uint _id) onlyOwner public returns (bool success) {
        require(_id > 0, "Debes indicar el id único de la medicina");

        uint i = _id-1;
        medicamentos[i].borrado = true;
        
        return true;
    }
}