# Ficha técnica de consumo de APIs externas

Para cumplir con los requisitos de transparencia y resiliencia del proyecto, se detallan los límites de las APIs externas que el microservicio de Analytics y otros consumen.

---

## 4.1. Hetzner (Infraestructura y Hosting)
* **Servicio:** Cloud Servers (VPS).
* **Garantía de Disponibilidad:** 99.9% de disponibilidad de red anual.
* **Ubicación:** Servidores ubicados en la Unión Europea, cumpliendo con el estándar GDPR para la protección de datos de los usuarios de 0debt.

---

## 4.2. Coolify (Infraestructura y Hosting)
* **Función:** Orquestador de contenedores. Se utiliza para desplegar todas las imágenes Docker de los microservicios de 0debt de forma automática.
* **Gestión de Secretos:** Coolify actúa como el almacén de variables de entorno seguras (API Keys de Resend, MongoDB URIs), inyectándose en tiempo de ejecución para cumplir con el Factor III (Config) de las 12-factor apps.

---

## 4.3. QuickChart (Generación de gráficos)
* **Servicio:** Quick Chart
* **Función:** Generación de gráficos
* **Microservicio consumidor:** analytics-service
* **Plan Utilizado:** Community (Free / Open Source).
* **Cuotas y Límites (Rate Limits):**
    * **Rate Limit:** 60 solicitudes por minuto (1 por segundo).
    * **Límite de Uso:** Máximo de 5,000 imágenes generadas al mes para usuarios no registrados en su API.
* **Características Técnicas:**
    * Basado en Chart.js v2.9.4.
    * Generación de imágenes en formato PNG/JPEG.
    * Latencia variable (servidores compartidos).
* **Mecanismo de Resiliencia en 0debt:** Se ha implementado un patrón Circuit Breaker con un timeout de 3000 ms. Si se superan los límites de Quick Chart o el servicio es lento, el sistema devolverá datos en formato texto o un valor nulo, garantizando que la aplicación siga funcionando.

### 4.3.1. Análisis Justificativo de la Suscripción Óptima - QuickChart

| Característica | Plan FREE (Elegido) | Plan PAID ($50/mes) |
| :--- | :--- | :--- |
| **Coste Mensual** | 0 € | ~47 € ($50) |
| **Límite de Rate** | 60 req/min | Ilimitado / Prioritario |
| **Marca de Agua** | No (Open Source) | No |
| **SLA de Soporte** | Comunitario (Best-effort) | Soporte técnico directo |
| **Privacidad** | Datos públicos en logs | Datos privados / No logs |

**Justificación de la elección:**
* **Ratio Coste/Beneficio:** Dado que 0debt está en fase de lanzamiento (MVP), el volumen de tráfico no justifica un gasto de ~50€ mensuales. El plan gratuito permite hasta 1.000 imágenes al mes, suficiente para cubrir a nuestros primeros usuarios PRO.
* **Mitigación de Riesgos:** La principal desventaja del plan gratuito es la falta de SLA y el límite de tasa. Hemos mitigado esto técnicamente:
    * **Throttling:** Nuestro API Gateway limita a los usuarios FREE para no agotar la cuota de la API externa.
    * **Resiliencia:** Si la API gratuita de QuickChart falla por saturación, nuestro Circuit Breaker actúa devolviendo un valor por defecto (0 o texto), evitando que el microservicio de Analytics se cuelgue.
* **Seguridad:** No enviamos datos PII (información personal identificable) a QuickChart, solo valores numéricos para las barras de progreso, por lo que el nivel de privacidad del plan gratuito es aceptable para este caso de uso.

---

## 4.4. Supabase (Almacenamiento Cloud)
* **Servicio:** Supabase Storage
* **Proveedor:** Supabase Inc.
* **Función:** Almacenamiento cloud para avatares de usuario.
* **Microservicio consumidor:** users-service
* **Cuotas y límites:** Tamaño máximo de archivo 1MB.
* **Características técnicas:** * Sistema de Object Storage basado en buckets.
    * Almacenamiento de imágenes en formatos estándar (jpeg, png, webp, avif, jpg)
    * Persistencia en base de datos limitada a la URL pública del recurso.

### 4.4.1. Análisis Justificativo de la Suscripción Óptima - Supabase 

| Característica | Plan FREE (Elegido) | Plan PRO | Plan TEAM |
| :--- | :--- | :--- | :--- |
| **Coste Mensual** | 0 $ | $25/mes | $599/mes |
| **API Requests** | Ilimitadas | Ilimitadas | Ilimitadas |
| **Monthly Active Users** | 50.000 | 100.000 | Incluido |
| **Almacenamiento DB** | 500 MB | 8 GB | Superior |
| **SLA** | No | Sí | Sí |
| **Soporte** | Comunitario | Email | Prioritario |
| **Seguridad avanzada** | No | No | SOC2 / SSO |

**Justificación de la elección:** * **Ratio Coste/Beneficio:** Dado que 0debt se encuentra en fase de lanzamiento (MVP), el volumen de usuarios y de contenido generado no justifica asumir un coste mensual de 25 $ correspondiente al plan PRO de Supabase. El plan gratuito ofrece 1 GB de almacenamiento de ficheros y 5 GB de egress, capacidad suficiente para cubrir las necesidades iniciales de almacenamiento de avatares de los primeros usuarios de la plataforma.
* **Mitigación de Riesgos:** La principal limitación del plan FREE es la ausencia de un SLA garantizado. Este riesgo se ha mitigado desde el punto de vista técnico y funcional:
    * **a. Funcionalidad no crítica:** El avatar es un elemento puramente visual que no afecta al flujo principal de autenticación ni al uso de la aplicación.
    * **b. Tolerancia a fallos:** En caso de indisponibilidad del servicio externo, el sistema continúa funcionando con normalidad, permitiendo al usuario utilizar la plataforma sin imagen personalizada.
* **Seguridad y Privacidad:** El uso de Supabase Storage no implica la exposición de datos personales sensibles. El microservicio users-service gestiona exclusivamente la subida de imágenes y almacena únicamente la URL pública del recurso, manteniendo las credenciales de acceso protegidas mediante variables de entorno y evitando el acceso directo desde el frontend. El nivel de privacidad del plan gratuito resulta adecuado para este caso de uso.

---

## 4.5. DiceBear API (Generación de imágenes de avatar)
* **Plan Utilizado:** API Pública 
* **Servicio:** DiceBear Avatars API
* **Función:** Generación automática de avatares
* **Microservicio consumidor:** users-service
* **URL:** https://api.dicebear.com
* **Características técnicas:** El avatar se genera dinámicamente cuando el cliente accede a la URL a partir de una semilla. Imágenes generadas en formato SVG.
* **Cuotas y Límites:** Coste gratuito, SLA no disponible.
* **Justificación de la elección:**
    * **Ratio Coste/Beneficio:** Al tratarse de un servicio gratuito, la API de DiceBear permite dotar de avatar a todos los usuarios desde el momento de su registro sin incurrir en ningún coste adicional.
    * **Simplicidad técnica:** La integración no requiere autenticación, SDKs ni llamadas HTTP activas desde el backend, reduciendo la complejidad y los puntos de fallo del sistema.
    * **Privacidad y seguridad:** No se envían datos personales sensibles al proveedor externo; únicamente se utiliza una cadena de texto como semilla para la generación del avatar.
    * **Funcionalidad no crítica:** En caso de indisponibilidad del servicio, el flujo de registro del usuario no se ve afectado y el avatar puede ser modificado posteriormente mediante la funcionalidad de subida de imágenes gestionada con Supabase Storage.

---

## 4.6. Unsplash API (Generación de imágenes aleatorias para grupos)
* **Plan Utilizado:** API Pública (Developer Plan)
* **Servicio:** Unsplash API
* **Función:** Generación automática de imágenes aleatorias para grupos (iconos o imágenes de portada)
* **Microservicio consumidor:** groups-service
* **URL:** https://api.unsplash.com
* **Características técnicas:**
    * Obtención de imágenes aleatorias mediante el endpoint photos.getRandom.
    * Selección automática de una imagen en el momento de la creación del grupo.
    * Uso de URLs públicas proporcionadas por Unsplash (no almacenamiento local obligatorio).
    * Imágenes optimizadas para uso web (formato JPEG, resolución adaptable).
    * Integración mediante la librería oficial unsplash-js.
* **Cuotas y Límites:**
    * Plan gratuito para desarrolladores.
    * Límite aproximado de 50 solicitudes por hora (según políticas de Unsplash).
    * SLA no garantizado.
* **Justificación de la elección:**
    * **Ratio Coste/Beneficio:** Unsplash ofrece un amplio catálogo de imágenes de alta calidad de forma gratuita, lo que permite asignar una imagen visual atractiva a cada grupo sin ningún coste económico.
    * **Simplicidad técnica:** La integración es sencilla y centralizada en el backend mediante una única llamada HTTP durante la creación del grupo. No requiere autenticación de usuario final ni flujos OAuth complejos, únicamente una API Key de servidor.
    * **Experiencia de usuario:** Asignar automáticamente una imagen al grupo mejora la identificación visual y la experiencia de navegación en el dashboard, incluso si el usuario no personaliza manualmente la imagen.
    * **Privacidad y seguridad:** No se envían datos personales a Unsplash. La solicitud se limita a una llamada genérica para obtener una imagen aleatoria, cumpliendo con principios de minimización de datos.
    * **Funcionalidad no crítica:** En caso de indisponibilidad de la API de Unsplash, la creación del grupo no se ve afectada. El sistema puede usar una imagen por defecto o permitir la modificación posterior de la imagen del grupo mediante Supabase Storage.

---

## 4.7. Frankfurter API (Conversión de divisas)
* **Plan Utilizado:** API Pública 
* **Servicio:** Frankfurter Currency Data API
* **Función:** Consulta de tipos de cambio actuales e históricos, con función de conversión de monedas.
* **Microservicio consumidor:** expenses-service
* **URL:** https://publicapis.io/frankfurter-api 
* **Características técnicas:** La API se sincroniza con los tipos de cambio de referencia publicados por el Banco Central Europeo (BCE). Devuelve respuestas en formato JSON, soporta consultas de series temporales y permite la conversión dinámica entre divisas sin necesidad de autenticación.			
* **Cuotas y Límites:** Coste gratuito, sin límites de peticiones estrictos (política de fair use), SLA no garantizado.							
* **Justificación de la elección:**							
    * **Ratio Coste/Beneficio:** Al ser un servicio open source y gratuito, permite ofrecer precios en moneda local y realizar conversiones internas sin incurrir en los altos costes de licencias de APIs financieras comerciales.							
    * **Simplicidad técnica:** La integración es extremadamente sencilla ya que no requiere gestión de API Keys, OAuth ni SDKs propietarios; funciona mediante peticiones HTTP GET estándar.
    * **Privacidad y seguridad:** La operación es totalmente anónima. No se comparte información financiera del cliente ni datos de transacciones con el proveedor; únicamente se envían los códigos de las divisas (ej. USD, EUR).						
    * **Funcionalidad no crítica:** En caso de indisponibilidad de la API externa, el sistema está diseñado para realizar un fallback a los últimos tipos de cambio almacenados en caché o mostrar los precios únicamente en la moneda base.

---

## 4.8. Resend API
* **Plan utilizado:** Plan gratuito para desarrollo (Free Tier)
* **Servicio:** Resend Email API
* **Función:** Envío de correos electrónicos transaccionales para notificaciones de eventos (creación de gastos, invitaciones a grupos, cambios de balance, resúmenes periódicos)
* **Microservicio consumidor:** notifications-service
* **URL:** https://resend.com
* **Características técnicas:** * Envío de emails mediante API REST con autenticación por API Key.
    * Soporte para plantillas HTML personalizadas con estilos embebidos.
    * Verificación de dominio personalizado (mail.0debt.xyz) para mejorar la entregabilidad.
    * Integración mediante el SDK oficial resend para Node.js/Bun.
    * Rate limiting para respetar los límites de la API.
    * Circuit Breaker pattern para proteger contra fallos del servicio externo.
* **Cuotas y límites:** El plan gratuito limita los emails a 100 al día y retiene la información por 1 día. Existen otros dos planes de pago y la posibilidad de crear un plan custom.
* **Justificación de la elección:** * **Ratio Coste/Beneficio:** Resend ofrece un plan gratuito generoso (100 emails/día) que es suficiente para las fases de desarrollo y pruebas, además en producción, el coste es también competitivo ($20/mes por 50,000 emails).
    * **Simplicidad técnica:** La API es sencilla de integrar, con un SDK moderno que utiliza Promises nativas. La configuración se reduce a una API Key y un dominio verificado. No requiere servidores SMTP ni gestión de colas complejas.
    * **Experiencia de usuario:** Los emails transaccionales mejoran significativamente la experiencia del usuario al mantenerlo informado en tiempo real sobre eventos relevantes.
    * **Privacidad y seguridad:** Solo se envían datos necesarios para la notificación (email del destinatario, asunto y contenido). El sistema cumple con GDPR al permitir que los usuarios configuren sus preferencias de notificación.
    * **Funcionalidad no crítica:** En caso de indisponibilidad de Resend, el sistema utiliza un Circuit Breaker que bloquea automáticamente las llamadas fallidas para evitar la degradación del rendimiento.