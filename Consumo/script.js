const urlAPI = 'http://localhost:5174/api/Pago';
const urlAPIpeajes = "https://www.datos.gov.co/resource/7gj8-j6i3.json";


async function obtenerDatos() {
  const respuesta = await fetch(urlAPI);
  const datos = await respuesta.json();

  datos.forEach(pago => {
    const contenedorDatos = document.getElementById('listar');
    const parrafo = document.createElement('tr');
    parrafo.innerHTML = `
        <td>${pago.id}</td>
        <td>${pago.placa}</td>
        <td>${pago.nombrePeaje}</td>
        <td>${pago.idCategoriaTarifa}</td>
        <td>${pago.fechaRegistro}</td>
        <td>${pago.valor}</td>
        <td>
          <button onclick="editarPago(${pago.id})" class="btn btn-success" type="button" data-bs-toggle="modal" data-bs-target="#exampleModal">Editar</button>
          <button onclick="eliminarPago(${pago.id})" class="btn btn-danger">Eliminar</button>
        </td>
        `;
    contenedorDatos.appendChild(parrafo);
  });
}
obtenerDatos();



async function eliminarPago(id) {
  Swal.fire({
    title: "¿Estas seguro que deseas eliminar?",
    showDenyButton: true,
    confirmButtonText: "SI",
  }).then((result) => {
    if (result.isConfirmed) {
      Swal.fire("Pago eliminado", "", "success");
      eliminar(id)
    }
  });
}
async function eliminar(id) {
  const urlUsuario = `http://localhost:5174/api/Pago/${id}`;
  try {
    const respuestaEliminacion = await fetch(urlUsuario, {
      method: 'DELETE'
    });
    window.location.reload()
  } catch (error) {
    console.error(`Error al eliminar usuario: ${error.message}`);
  }
}


const formulario = document.getElementById('formulario-registro');
const mensajeRespuesta = document.getElementById('mensaje-respuesta');
const selectNombrePeaje = document.getElementById("nombrePeaje");
const selectIdCategoria = document.getElementById("idcategoria");
const Valor = document.getElementById("valor");
const NombrePeaje = document.getElementById("nombrePeaje").value;
const IdCategoria = document.getElementById("idcategoria").value;

async function cargarNombresPeaje() {
  const nombresUnicos = new Set();
  try {
    const respuesta = await fetch(urlAPIpeajes);
    const datos = await respuesta.json();

    datos.forEach(peaje => {
      if (!nombresUnicos.has(peaje.peaje)) {
        const option = document.createElement('option');
        option.value = peaje.peaje;
        option.textContent = peaje.peaje;
        selectNombrePeaje.appendChild(option);

        nombresUnicos.add(peaje.peaje);
      }
    });
  } catch (error) {
    mensajeRespuesta.textContent = `Error al cargar nombres: ${error.message}`;
  }
}


async function cargarIdCategoriaTarifa() {
  const categoriaUnicos = new Set()
  try {
    const respuesta = await fetch(urlAPIpeajes);
    const datos = await respuesta.json();

    datos.forEach(tarifa => {
      if (!categoriaUnicos.has(tarifa.idcategoriatarifa)) {
        const option = document.createElement('option');
        option.value = tarifa.idcategoriatarifa;
        option.textContent = tarifa.idcategoriatarifa;
        selectIdCategoria.appendChild(option)

        categoriaUnicos.add(tarifa.idcategoriatarifa)
      }
    });
  } catch (error) {
    mensajeRespuesta.textContent = `Error al cargar nombres: ${error.message}`;
  }
}

async function cargarValor() {
  const nombre = selectNombrePeaje.value;
  const categoria = selectIdCategoria.value;

  if (nombre && categoria) {
    try {
      const respuesta = await fetch(urlAPIpeajes);
      const datos = await respuesta.json();

      datos.forEach(tarifa => {
        if (nombre == tarifa.peaje && categoria == tarifa.idcategoriatarifa) {
          valor.value = tarifa.valor
        }

      }
      );
    } catch (error) {
      mensajeRespuesta.textContent = `Error al cargar valor: ${error.message}`;
    }
  }

}

selectNombrePeaje.addEventListener("change", cargarValor)
selectIdCategoria.addEventListener("change", cargarValor)

cargarNombresPeaje()
cargarIdCategoriaTarifa()

formulario.addEventListener('submit', async (event) => {
  event.preventDefault();

  const datosRegistro = {
    Placa: document.getElementById('placa').value,
    NombrePeaje: document.getElementById('nombrePeaje').value,
    IdCategoriaTarifa: document.getElementById('idcategoria').value,
    FechaRegistro: document.getElementById('fechaRegistro').value,
    Valor: document.getElementById('valor').value
  };

  try {
    const respuesta = await fetch(urlAPI, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(datosRegistro)
    });

    const resultado = await respuesta.json();

    if (respuesta.ok) {
      mensajeRespuesta.textContent = `Registro exitoso: ${resultado.id}`;
    } else {
      mensajeRespuesta.textContent = `Error al registrar: ${resultado.message}`;
    }
  } catch (error) {
    mensajeRespuesta.textContent = `Error de red: ${error.message}`;
  }
});