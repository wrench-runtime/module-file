import "buffer" for Buffer

class FileMode {
  static Read { "rb" }
  static Write { "wb" }
  static Append { "ab" }
}

class SeekOrigin {
  static Start { 0 }
  static Current { 1 }
  static End { 2 }
}

foreign class FileStream {
  foreign size
  foreign position
  foreign seek(pos, origin) 
  foreign write(str)
  foreign read(bytes)
  
  foreign writeBuffer_(buffer)
  writeBuffer(buffer){
    seek(0, SeekOrigin.Start)
    writeBuffer_(buffer)
  }
  foreign readBuffer_(buffer)
  readBuffer(){
    // TODO: Get rid of the zero terminator
    var buffer = Buffer.new(size+1)
    seek(0, SeekOrigin.Start)
    readBuffer_(buffer)
    return buffer
  }

  foreign close()
  dispose(){
    close()
  }
}

class File {
  foreign static open_(streamClass, path, mode)
  static open(path, mode){
    return open_(FileStream, path, mode)
  }
  static read(path){
    var f = open(path, FileMode.Read)
    var content = f.read(f.size)
    f.close()
    return content
  }
  static readBuffer(path){
    var f = open(path, FileMode.Read)
    var b = f.readBuffer()
    f.close()
    return b
  }
  static writeBuffer(path, buffer){
    var f = open(path, FileMode.Write)
    f.writeBuffer(buffer)
    f.close()
  }
  static write(path, content){
    var f = open(path, FileMode.Write)
    f.write(content)
    f.close()
  }
  static append(path, content){
    var f = open(path, FileMode.Append)
    f.write(content)
    f.close()
  }
  static size(path){
    var f = open(path, FileMode.Read)
    var s = f.size
    f.close()
    return s
  }
  foreign static delete(path)
  foreign static exists(path)
}
