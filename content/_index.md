---
title: "¡Hola! Soy Pedro Pardal"
description: "Soy desarrollador de software, líder técnico y emprendedor"
date: 2024-12-05T00:00:00+02:00
layout: landing
blocks:
  # Hero
  - type: hero
    id: sect-hero
    className: dark
    header: ¡Hola! Soy Pedro Pardal
    subheader: Soy desarrollador de software, líder técnico y emprendedor
    backgroundImage: "/images/hero-background.jpg"

  # Subscribe to newsletter form
  - type: newsletter-subscribe
    id: sect-newsletter-subscribe
    className: dark

  # The value proposition
  - type: three-steps
    id: sect-value-proposition
    className: light
    header: ¿A qué me dedico?
    subtitle: "Utilizo mi amplia experiencia en realizar re-ingeniería de sistemas legacy, construir servicios escalables en la nube y adoptar prácticas de desarrollo ágil y DevOps, para:"
    steps:
      - number: "1"
        title: "Asesoría"
        description: "Ayudo a empresas para definir una estrategia que les permita superar sus mayores retos de desarrollo de software."
        button_text: "Saber más"
        scroll_target: "sect-service-consultancy"
      - number: "2"
        title: "Formación"
        description: "Capacito a programadores y equipos en buenas prácticas y metodologías de desarrollo, diseño y arquitectura de software."
        button_text: "Saber más"
        scroll_target: "sect-service-training"
      - number: "3"
        title: "Desarrollo"
        description: "Desarrollo soluciones software a medida de alta calidad."
        button_text: "Saber más"
        scroll_target: "sect-service-development"

  # Who am I?
  - type: guide
    id: sect-team
    className: light
    title: Sobre mí
    p1: Pedro es Software engineer y tech lead con +12 años de experiencia construyendo aplicaciones web escalables en el cloud, y liderando equipos multidisciplinares usando metodologías ágiles.
    p2: Inspirado por los valores de Software Craftsmanship y prácticas de Extreme Programming y DevOps, poniendo especial énfasis en la entrega temprana de valor, comunicación transparente con el cliente y excelencia técnica.
    image: '/images/team/pedro-bilbo.jpg'

  # Clients
  - type: clients

  # Testimonials
  - type: testimonials
    id: sect-testimonials
    className: light
    header: "Qué dicen sobre mí:"
    testimonials:
    - name: "Abraham Vallez"
      position: "Engineering Manager @ Zinklar"
      photo: "/images/testimonials/abraham-vallez.png"
      text: "&ldquo;Desde que Pedro llegó al equipo se involucró desde el minuto 1, tanto en el producto como en la parte técnica, siendo una pieza clave en la gran mejora sistémica que experimentó el equipo, ayudando no solo en detalles técnicos si no en las interacciones, relaciones y otras dinámicas de equipo.&rdquo;"
      active: true
    - name: "Gerard Artés"
      position: "CTO & Co-founder @ BAB"
      photo: "/images/testimonials/gerard-artes.jpg"
      text: "&ldquo;Ver al equipo motivado y con ganas ha sido muy positivo. Gana el equipo, gana la empresa y también ganan los empleados a nivel personal ya que obtienen un aprendizaje y una formación extra que tiene un retorno muy positivo&rdquo;"
    - name: "Emilio Macías"
      position: "Director de operaciones @ AIDA (Domingo Alonso Group)"
      photo: "/images/testimonials/emilio-macias.jpeg"
      text: "&ldquo;Tras empezar a trabajar con Exeal, volvemos a respirar en el equipo el aprendizaje, las preguntas, las lecturas... El éxito principal es ayudar a crecer y retener a nuestros profesionales.&rdquo;"

  # Contact form
  - type: contact-form
    id: sect-contact
    className: dark
    title: <em>Déjame un mensaje</em> y contactaré contigo lo antes posible.
---
