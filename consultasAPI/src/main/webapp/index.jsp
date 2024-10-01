<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CONSULTAS API</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .json-result {
            background-color: #f8f9fa;
            padding: 10px;
            border-radius: 5px;
            margin-top: 10px;
            overflow-x: auto;
        }
        .result {
            display: none;
        }
        pre {
            white-space: pre-wrap;
            margin: 0;
        }
    </style>
</head>
<body>

<div class="container mt-5">
    <h1 class="text-center mb-4">CONSULTAS API</h1>

    <div class="row">
        <div class="col-md-4 mb-4">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">API de Clima</h5>
                    <form id="weatherForm">
                        <input type="hidden" name="action" value="Get Weather">
                        <div class="form-group">
                            <label for="city">Ingrese la ciudad:</label>
                            <input type="text" id="city" name="city" class="form-control" placeholder="Ejemplo: Bogotá" required>
                        </div>
                        <button type="submit" class="btn btn-primary btn-block">Consultar Clima</button>
                    </form>
                </div>
            </div>
        </div>

        <div class="col-md-4 mb-4">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">API de TRM</h5>
                    <form id="trmForm">
                        <input type="hidden" name="action" value="Get TRM">
                        <button type="submit" class="btn btn-info btn-block">Consultar TRM</button>
                    </form>
                </div>
            </div>
        </div>

        <div class="col-md-4 mb-4">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">API Rick y Morty</h5>
                    <form id="rickForm">
                        <input type="hidden" name="action" value="Get Rick and Morty Characters">
                        <button type="submit" class="btn btn-success btn-block">Consultar Personajes</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <div class="mt-5">
        <h3>Resultados:</h3>

        <div id="weatherResult" class="result">
            <h5>Clima:</h5>
            <div class="json-result">
                <h6>JSON Completo:</h6>
                <pre id="weatherJson"></pre>
            </div>
        </div>

        <div id="trmResult" class="result">
            <h5>TRM:</h5>
            <div class="json-result">
                <h6>JSON Completo:</h6>
                <pre id="trmJson"></pre>
            </div>
        </div>

        <div id="rickResult" class="result">
            <h5>Personajes de Rick y Morty:</h5>
            <div class="json-result">
                <h6>JSON Completo:</h6>
                <pre id="rickJson"></pre>
            </div>
        </div>
    </div>
</div>

<script>
    // Función para formatear JSON
    function formatJson(jsonData) {
        return JSON.stringify(jsonData, null, 2);
    }

    // Ocultar todas las secciones de resultados
    function hideAllResults() {
        document.getElementById('weatherResult').style.display = 'none';
        document.getElementById('trmResult').style.display = 'none';
        document.getElementById('rickResult').style.display = 'none';
    }

    // Mostrar JSON del clima
    function updateWeather(data) {
        hideAllResults(); // Ocultar las demás secciones
        document.getElementById('weatherResult').style.display = 'block';
        document.getElementById('weatherJson').textContent = formatJson(data);
    }

    // Mostrar JSON de TRM
    function updateTRM(data) {
        hideAllResults(); // Ocultar las demás secciones
        document.getElementById('trmResult').style.display = 'block';
        document.getElementById('trmJson').textContent = formatJson(data);
    }

    // Mostrar JSON de Rick y Morty
    function updateRickAndMorty(data) {
        hideAllResults(); // Ocultar las demás secciones
        document.getElementById('rickResult').style.display = 'block';
        document.getElementById('rickJson').textContent = formatJson(data);
    }

    // Evento para formulario del clima
    document.getElementById('weatherForm').addEventListener('submit', function (event) {
        event.preventDefault();
        const city = document.getElementById('city').value;
        fetch('weatherServlet', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: new URLSearchParams({ action: 'Get Weather', city })
        })
            .then(response => response.json())
            .then(data => updateWeather(data));
    });

    // Evento para formulario de TRM
    document.getElementById('trmForm').addEventListener('submit', function (event) {
        event.preventDefault();
        fetch('weatherServlet', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: new URLSearchParams({ action: 'Get TRM' })
        })
            .then(response => response.json())
            .then(data => updateTRM(data));
    });

    // Evento para formulario de Rick y Morty
    document.getElementById('rickForm').addEventListener('submit', function (event) {
        event.preventDefault();
        fetch('weatherServlet', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: new URLSearchParams({ action: 'Get Rick and Morty Characters' })
        })
            .then(response => response.json())
            .then(data => updateRickAndMorty(data));
    });
</script>

</body>
</html>