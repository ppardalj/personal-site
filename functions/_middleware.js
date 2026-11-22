// Redirige el dominio raíz a www (301), conservando ruta y query.
// Solo actúa en el raíz: www y las previews de *.pages.dev pasan tal cual.
// static/_routes.json excluye los assets para que no invoquen esta función.
const APEX = "ppardalj.com";

export const onRequest = ({ request, next }) => {
  const url = new URL(request.url);
  if (url.hostname !== APEX) return next();
  url.hostname = `www.${APEX}`;
  return Response.redirect(url.toString(), 301);
};
