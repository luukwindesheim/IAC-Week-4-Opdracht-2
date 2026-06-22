# Opdracht 4 — Includes en Imports

## Verschil tussen import_tasks en include_tasks

| | import_tasks | include_tasks |
|---|---|---|
| Wanneer ingeladen | Voor uitvoering (statisch) | Tijdens uitvoering (dynamisch) |
| Werkt met variabelen die later worden gezet | Nee | Ja |
| `when` gedrag | Wordt op elke taak apart toegepast | Wordt om het hele bestand heen gewikkeld |
| Gebruik | Vaste taken die altijd hetzelfde zijn | Taken die afhangen van een conditie of variabele |

### Wanneer gebruik je welke?

**import_tasks** gebruik je als je taken altijd wil inladen en de inhoud van het bestand van tevoren bekend is. Ansible leest het bestand in vóór het playbook start, waardoor tags en handlers correct werken.

**include_tasks** gebruik je als je taken dynamisch wil inladen, bijvoorbeeld afhankelijk van een variabele of het resultaat van een eerdere taak. Het bestand wordt pas ingeladen op het moment dat de taak aan de beurt is.

## Waarom zijn roles handig?

Roles zorgen voor herbruikbaarheid en overzicht:

- **Herbruikbaar** — een role zoals `role_firewall` kun je in meerdere playbooks gebruiken zonder de code te kopiëren.
- **Overzichtelijk** — taken, variabelen en handlers staan gegroepeerd per functie in plaats van alles in één groot playbook.
- **Makkelijk te delen** — roles kun je delen via Ansible Galaxy of tussen projecten kopiëren.
