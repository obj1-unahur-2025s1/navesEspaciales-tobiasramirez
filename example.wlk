class Nave{
  var velocidad
  var direccion
  var property combustible = 0
  method acelerar(cuanto) {velocidad = 0.max(100000.min(velocidad + cuanto))}
  method desacelerar(cuanto) {velocidad =  0.max(100000.min(velocidad - cuanto)) }
  method irHaciaElSol() {direccion = 10}
  method escaparDelSol() {direccion = -10}
  method ponerseParaleloAlSol() {direccion = 0}
  method acercarseUnPocoAlSol() {direccion = 10.min(direccion + 1)}
  method alejarseUnPocoDelSol() {direccion = -10.max(direccion - 1)}
  method prepararViaje() {
    self.combustible(30000)
    self.acelerar(5000)
  }
  method estaTranquila() = combustible >= 4000 && velocidad <= 12000
  method recibirAmenaza() {
    self.escapar()
    self.avisar()
  }
  method escapar()
  method avisar()
  method estaDeRelajo() = self.estaTranquila() && self.tienePocaActividad()
  method tienePocaActividad()
}
class NaveBaliza inherits Nave {
  var colorMostrado = "azul"
  var cambiosDeColor = 0
  method cambiarColorDeBaliza(colorNuevo) {
    colorMostrado=colorNuevo
    cambiosDeColor +=1
    }
  override method prepararViaje() {
    super()
    colorMostrado= "verde"
    self.ponerseParaleloAlSol()
  }
  override method estaTranquila() =  super() && colorMostrado != "rojo"
  override method escapar() {self.irHaciaElSol()}
  override method avisar() {self.cambiarColorDeBaliza("rojo")}
  override method tienePocaActividad() = cambiosDeColor == 0
}
class NaveDePasajeros inherits Nave{
  var pasajeros 
  var comidaCargada = 0
  var racionesDeComida = 0
  var racionesDeBebida = 0
  method cargarComida(raciones) {
    racionesDeComida += raciones
    comidaCargada+=1
    }
  method descargarComida(raciones) {racionesDeComida = 0.max(racionesDeComida-raciones)}
  method cargarBebida(raciones) {racionesDeBebida+=raciones}
  method descargarBebida(raciones) {racionesDeBebida= 0.max(racionesDeBebida-raciones)}
  override method prepararViaje() {
    super()
    self.cargarComida(4 * pasajeros)
    self.cargarBebida(6 * pasajeros)
    self.acercarseUnPocoAlSol()
  }
  override method escapar() {velocidad=velocidad*2}
  override method avisar() {
    racionesDeComida -= pasajeros.size()
    racionesDeBebida -= pasajeros.size() * 2
    }
  override method tienePocaActividad() = comidaCargada <= 50
  
}
class NaveDeCombate inherits Nave {
  var estaInvisible 
  var misilesDesplegados
  var mensajesEmitidos = []
  method ponerseVisible() {estaInvisible = false}
  method ponerseInvisible() {estaInvisible = true}
  method estaInvisible() = estaInvisible
  method misilesDesplegados() = misilesDesplegados
  method desplegarMisiles() {misilesDesplegados = true}
  method replegarMisiles() {misilesDesplegados=false}
  method emitirMensaje(unMensaje) {mensajesEmitidos.add(unMensaje).toString()}
  method mensajesEmitidos() = mensajesEmitidos
  method primerMensajeEmitido() = mensajesEmitidos.first()
  method ultimoMensajeEmitido() = mensajesEmitidos.last()
  method esEscueta() = mensajesEmitidos.all({m=>m.size() <= 30 })
  method emitioMensaje(mensaje) = mensajesEmitidos.contains(mensaje)
  override method prepararViaje(){
    super()
    estaInvisible = false
    misilesDesplegados=false
    self.acelerar(15000)
    self.emitirMensaje("saliendo en misión")
  }
  override method estaTranquila() = super() && !misilesDesplegados
  override method escapar() {
    self.acercarseUnPocoAlSol()
     self.acercarseUnPocoAlSol()}

  override method avisar() {self.emitirMensaje("amenaza recibida")}
  
}
class NaveHospital inherits NaveDePasajeros {
  var quirofanosPreparados = false
  method quirofanosPreparados() = quirofanosPreparados
  method prepararQuirofanos() {quirofanosPreparados = true}
  override method estaTranquila() = super() && !quirofanosPreparados
  override method recibirAmenaza() {
    super()
    self.prepararQuirofanos()
  }
}
class NaveDeCombateSigilosa inherits NaveDeCombate {
 override method estaTranquila() = super() && estaInvisible
 override method recibirAmenaza() {
  super()
  self.desplegarMisiles()
  self.ponerseInvisible()
  
 }
}