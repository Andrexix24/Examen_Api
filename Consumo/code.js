async function editarPago(id){
    const urlAPIEditar=`http://localhost:5174/api/Pago/${id}`;
    const modal=document.getElementById("modal")
    modal.innerHTML=`
            <div class="modal-header">
              <h5 class="modal-title">Editar</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
              <form id="formulario-registro1">
                <label for="placa" class="form-label">Placa:</label>
                  <input type="text" id="placa" name="placa" class="form-control" required/><br />
                <label for="nombrePeaje" class="form-label">Nombre peaje:</label>
                <select id="nombrePeaje" name="nombrePeaje" class="form-control" required>
                  <option value="">Seleccionar...</option>
                  <option value="hola">Hola...</option></select>
                </select>
                  <br />
                <label for="idcategoria" class="form-label">ID categoría:</label>
                <select type="text" id="idcategoria" name="idcategoria" class="form-control" required>
                  <option value="">Seleccionar...</option>
                  <option value="I">I</option></select>
                </select>
                <br />
                <label for="fechaRegistro" class="form-label">Fecha registro:</label>
                  <input type="text" id="fechaRegistro" name="fechaRegistro" class="form-control" required/><br />
                <label for="valor" class="form-label">Valor:</label>
                  <input class="form-control" id="valor" type="number" disabled />
                <br />
  
                <button type="submit" class="btn btn-success">Registrar</button>
              </form>
  
              <div id="mensaje-respuesta" class="m-1"></div>
              
              <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
    `
    

    try {
      const respuesta = await fetch(urlAPIEditar);
      const datos = await respuesta.json();
  
      console.log(datos)
  
      const placa = document.getElementById("placa");
      const fecha = document.getElementById("fechaRegistro");
      const valor = document.getElementById("valor");
      const formulario = document.getElementById('formulario-registro1');
  
      placa.value = datos.placa;
      fecha.value = datos.fechaRegistro;
      valor.value = datos.valor;

      
      formulario.addEventListener('submit', async (event) => {
        event.preventDefault();
      
        
        const datosActualizados = {
            Id: 1,
            Placa: document.getElementById('placa').value,
            NombrePeaje: document.getElementById('nombrePeaje').value,
            IdCategoriaTarifa: document.getElementById('idcategoria').value,
            FechaRegistro: document.getElementById('fechaRegistro').value,
            Valor: document.getElementById('valor').value
        };
      
        await editarDatos(id, datosActualizados);
      });
    } catch (error) {
      console.error(`Error al eliminar usuario: ${error.message}`);
    }
  }

  
  async function editarDatos(id, datosActualizados) {
    console.log(id)
    console.log(datosActualizados)
    const url = `http://localhost:5174/api/Pago/${id}`;
    const opciones = {
      method: 'PUT',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(datosActualizados)
    };
  
    try {
      const respuesta = await fetch(url, opciones);
      const datos = await respuesta.json();
  
      if (respuesta.ok) {
        console.log('Datos editados correctamente');
        // Actualizar la interfaz de usuario con los datos editados
      } else {
        console.error('Error al editar datos:', datos.error);
        // Mostrar un mensaje de error al usuario
      }
    } catch (error) {
      console.error('Error de red:', error);
      // Mostrar un mensaje de error de red al usuario
    }
  }
  