<!doctype html>
<html lang="es">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta
      name="description"
      content="LeadLearn CloudOps: monitoreo de la canalización de datos y recursos en Azure."
    />
    <title>LeadLearn · CloudOps</title>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700&family=Manrope:wght@600;700;800&display=swap"
      rel="stylesheet"
    />
    <link rel="stylesheet" href="styles.css" />
    <script src="app.js" type="module"></script>
  </head>
  <body>
    <div class="app-shell">
      <aside class="sidebar" id="sidebar" aria-label="Navegación principal">
        <a class="brand" href="#" aria-label="LeadLearn, inicio">
          <span class="brand__mark" aria-hidden="true">
            <svg viewBox="0 0 32 32" role="img">
              <path d="M8 7.5h7v17H8zM17 12h7v12.5h-7z" />
              <path class="brand__spark" d="m20.5 4 1.15 2.35L24 7.5l-2.35 1.15L20.5 11l-1.15-2.35L17 7.5l2.35-1.15z" />
            </svg>
          </span>
          <span>Lead<span>Learn</span></span>
        </a>

        <nav class="nav-list">
          <p class="nav-label">Espacio de trabajo</p>
          <a class="nav-item is-active" href="#resumen" aria-current="page">
            <span data-icon="grid"></span> Resumen
          </a>
          <a class="nav-item" href="#pipeline"><span data-icon="flow"></span> Pipeline</a>
          <a class="nav-item" href="#recursos"><span data-icon="cloud"></span> Recursos</a>
          <a class="nav-item" href="#actividad"><span data-icon="pulse"></span> Actividad</a>
          <p class="nav-label nav-label--second">Administración</p>
          <a class="nav-item" href="#equipo"><span data-icon="users"></span> Equipo</a>
          <a class="nav-item" href="#configuracion"><span data-icon="settings"></span> Configuración</a>
        </nav>

        <div class="sidebar-card">
          <span class="sidebar-card__icon" data-icon="shield"></span>
          <div>
            <strong>Entorno protegido</strong>
            <p>Identidad administrada y RBAC activos.</p>
          </div>
          <button class="text-button" type="button" data-toast="La guía de seguridad estará disponible próximamente.">Ver seguridad</button>
        </div>

        <div class="profile">
          <span class="avatar" aria-hidden="true">YF</span>
          <span><strong>Yan Franco</strong><small>Administrador</small></span>
          <button class="icon-button" aria-label="Opciones de perfil" data-toast="Menú de perfil abierto.">
            <span data-icon="more"></span>
          </button>
        </div>
      </aside>

      <main class="main-content" id="resumen">
        <header class="topbar">
          <button class="icon-button menu-button" id="menuButton" aria-label="Abrir menú" aria-controls="sidebar" aria-expanded="false">
            <span data-icon="menu"></span>
          </button>
          <div class="topbar__title">
            <p>PLATAFORMA DE DATOS</p>
            <h1>Centro de operaciones</h1>
          </div>
          <div class="topbar__actions">
            <button class="icon-button notification-button" aria-label="Notificaciones" data-toast="No tienes alertas nuevas.">
              <span data-icon="bell"></span><i aria-hidden="true"></i>
            </button>
            <button class="button button--primary" id="runPipeline">
              <span data-icon="play"></span> Ejecutar pipeline
            </button>
          </div>
        </header>

        <section class="hero" aria-labelledby="welcome-title">
          <div>
            <span class="eyebrow"><i></i> Sistemas operativos</span>
            <h2 id="welcome-title">Buenos días, Yan <span aria-hidden="true">✦</span></h2>
            <p>Esta es la salud de tu plataforma de datos hoy.</p>
          </div>
          <div class="hero__meta">
            <span data-icon="clock"></span>
            <span>Próxima ejecución<strong>Hoy, 01:00 AM</strong></span>
          </div>
        </section>

        <section class="metrics-grid" id="metricas" aria-label="Métricas principales"></section>

        <section class="content-grid">
          <article class="panel pipeline-panel" id="pipeline">
            <div class="panel__header">
              <div>
                <span class="section-kicker">FLUJO PRINCIPAL</span>
                <h3>Pipeline de procesamiento</h3>
              </div>
              <ll-status-pill tone="success" label="Saludable"></ll-status-pill>
            </div>
            <div class="pipeline-flow" id="pipelineFlow" aria-label="Etapas de la canalización"></div>
            <div class="pipeline-footer">
              <div class="run-info">
                <span class="run-info__icon" data-icon="check"></span>
                <span>Última ejecución<strong id="lastRunText">Completada en 3m 42s</strong></span>
              </div>
              <button class="button button--soft" type="button" data-toast="Detalle de ejecución cargado.">Ver detalle <span data-icon="arrow"></span></button>
            </div>
          </article>

          <article class="panel storage-panel">
            <div class="panel__header">
              <div>
                <span class="section-kicker">ALMACENAMIENTO</span>
                <h3>Uso de Storage</h3>
              </div>
              <button class="icon-button" aria-label="Más opciones" data-toast="Opciones de Storage abiertas."><span data-icon="more"></span></button>
            </div>
            <div class="donut-wrap">
              <div class="donut" role="img" aria-label="12.8 gigabytes usados de 50">
                <div><strong>12.8</strong><span>GB usados</span></div>
              </div>
            </div>
            <div class="storage-legend">
              <span><i class="dot dot--primary"></i><strong>raw</strong><small>8.2 GB</small></span>
              <span><i class="dot dot--accent"></i><strong>processed</strong><small>4.6 GB</small></span>
            </div>
            <div class="capacity"><span><i></i></span><small>25.6% de 50 GB</small></div>
          </article>
        </section>

        <section class="lower-grid">
          <article class="panel activity-panel" id="actividad">
            <div class="panel__header">
              <div>
                <span class="section-kicker">MONITOREO</span>
                <h3>Actividad reciente</h3>
              </div>
              <button class="text-link" type="button" data-toast="Mostrando toda la actividad.">Ver todo <span data-icon="arrow"></span></button>
            </div>
            <div class="activity-list" id="activityList"></div>
          </article>

          <article class="panel resources-panel" id="recursos">
            <div class="panel__header">
              <div>
                <span class="section-kicker">INFRAESTRUCTURA</span>
                <h3>Recursos Azure</h3>
              </div>
              <span class="resource-count">5 activos</span>
            </div>
            <div class="resource-list" id="resourceList"></div>
          </article>
        </section>

        <footer class="footer">
          <span>LeadLearn CloudOps</span>
          <span>Región: East US 2 <i></i> Todos los servicios disponibles</span>
        </footer>
      </main>
    </div>

    <div class="scrim" id="scrim"></div>
    <div class="toast-region" id="toastRegion" aria-live="polite" aria-atomic="true"></div>
  </body>
</html>
