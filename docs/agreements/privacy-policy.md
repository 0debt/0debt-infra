# Política de Privacidad y Protección de Datos - 0debt

Esta Política de Privacidad describe cómo **0debt Financial Solutions** ("Compañía") recopila, utiliza y protege la información de sus Clientes y Usuarios, cumpliendo con el **Reglamento General de Protección de Datos (GDPR)** y la **Ley Orgánica 3/2018 (LOPDGDD)** de España.

---

## 1. Introducción y Roles en el Tratamiento

**1.1 0debt como Responsable del Tratamiento:** Gestionamos los datos de registro (email), facturación y métricas de uso para mantener la relación comercial y técnica con el Cliente.

**1.2 0debt como Encargado del Tratamiento:** Procesamos los datos financieros, gastos compartidos, nombres de grupos e imágenes de avatar que el Usuario introduce únicamente para prestar el Servicio de cálculo de deuda.

---

## 2. Bases Legales para el Tratamiento

Basamos nuestras actividades de tratamiento en los siguientes pilares (Art. 6 GDPR):
* **Ejecución del Contrato:** Para gestionar grupos, calcular deudas y procesar suscripciones PRO/ENTERPRISE.
* **Obligación Legal:** Cumplimiento de normativas fiscales españolas y seguridad de la información.
* **Interés Legítimo:** Mejora de los algoritmos de analítica y seguridad del API Gateway frente a ingeniería inversa.
* **Consentimiento:** Para el envío de resúmenes de actividad y notificaciones avanzadas de deuda.

---

## 3. Derechos de los Usuarios

Los usuarios de 0debt pueden ejercer sus derechos de:
1. **Acceso y Rectificación:** Consultar y corregir sus balances y perfil.
2. **Supresión (Derecho al Olvido):** Mediante la eliminación de cuenta, lo cual activa nuestro **protocolo SAGA** de borrado distribuido.
3. **Portabilidad:** Solicitar la exportación de sus datos de gastos en formato estructurado (JSON/CSV).
4. **Oposición:** Desactivar notificaciones de alertas de deuda desde el panel de control.

---

## 4. Uso de Datos con Servicios de Terceros (Underpinning Contracts)

Para el funcionamiento de la arquitectura microservicio de 0debt, compartimos datos mínimos con proveedores que cumplen estrictamente con el GDPR:

* **Infraestructura (Hetzner Online GmbH):** Alojamiento de la base de datos y microservicios en la UE (Alemania/Finlandia).
* **Notificaciones (Resend):** Procesamiento de correos electrónicos para invitaciones y alertas de deuda.
* **Analítica Visual (QuickChart):** Se envían datos numéricos anonimizados para la generación de gráficos de gastos.
* **Pasarelas de Pago:** Datos de facturación para la gestión de suscripciones PRO y ENTERPRISE.

---

## 5. Período de Conservación y Protocolo SAGA

**5.1 Datos de Cuenta:** Se conservan mientras la cuenta esté activa. Tras la baja, se mantienen bloqueados durante los plazos legales (5 años para temas fiscales).

**5.2 Datos Operativos (Gastos/Grupos):** Siguiendo nuestro protocolo de consistencia eventual **SAGA**, si un usuario elimina su cuenta, sus preferencias, historial de alertas y datos vinculados se eliminarán permanentemente de todos los microservicios en un plazo máximo de **24 horas**.

**5.3 Copias de Seguridad:** Las copias en **MongoDB Atlas** se retienen según el plan (7 días FREE, 30 días PRO, 60 días ENTERPRISE), tras lo cual se sobrescriben de forma segura.

---

## 6. Seguridad de la Infraestructura

0debt es una plataforma **SaaS Cloud-Native** alojada en servidores seguros. Aplicamos medidas técnicas avanzadas como:
* Protección de endpoints mediante **API Gateway** con validación de JWT.
* Aislamiento de microservicios en contenedores gestionados por **Coolify**.
* Limitación de tasa (*Rate Limiting*) para prevenir ataques de denegación de servicio y raspado de datos.

---

## 7. Propiedad Intelectual de los Datos

**7.1 Del Cliente:** Usted conserva la propiedad total sobre los gastos, nombres de grupos e imágenes subidas. 0debt no comercializa ni vende su información financiera a terceros.

**7.2 Del Proveedor:** 0debt retiene todos los derechos sobre el código fuente, los algoritmos de optimización de deuda y la marca.