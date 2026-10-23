# LeadLearn CloudOps

Panel web estático y responsive para supervisar la arquitectura Azure documentada en este repositorio: extracción con Container Apps Jobs, almacenamiento Blob, procesamiento con Data Factory, secretos en Key Vault y acceso mediante RBAC.

## Ejecutar localmente

No requiere instalación ni proceso de compilación.

```bash
python3 -m http.server 4173
```

Abrir `http://localhost:4173`.

## Sistema visual

La paleta está definida como variables CSS en `:root` dentro de `styles.css`:

- Primario: verdes petróleo y jade (`--primary-*`).
- Acento: ámbar (`--accent-*`).
- Neutros: tinta, gris verdoso, lienzo y superficie (`--ink-*`, `--canvas`, `--surface`).
- Estados secundarios: azul, violeta y rojo suave.

La interfaz usa `Manrope` para títulos y `DM Sans` para texto de lectura.

## Componentes reutilizables

- `ll-status-pill`: indicador compacto de estado.
- `ll-metric-card`: tarjeta de métrica configurable mediante atributos `data-*`.
- `.panel`: contenedor base para módulos de contenido.
- `.button`, `.button--primary`, `.button--soft`: variantes de acciones.
- `.activity-row`, `.resource-row`, `.pipeline-step`: patrones repetibles alimentados desde datos en `app.js`.
- Sistema de iconos SVG centralizado en `app.js` para mantener consistencia visual.

La maqueta incluye navegación móvil, estados de foco, soporte para movimiento reducido, notificaciones tipo toast y una simulación de ejecución manual del pipeline.
