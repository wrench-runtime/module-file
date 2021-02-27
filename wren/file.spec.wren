import "augur" for Augur, Assert
import "file" for File, FileMode, SeekOrigin
import "buffer" for Buffer

Augur.describe("File") {

  Augur.it("should create new file"){
    var name = "./newfile.txt"
    var f = File.open(name, FileMode.Write)
    f.close()
    Assert.isTrue(File.exists(name))
    File.delete(name)
    Assert.isFalse(File.exists(name))
  }

  Augur.it("should read file"){
    var name = "./testfile.txt"
    File.write(name, "This is a test file.💋")
    var content = File.read(name)
    File.delete(name)
    Assert.equal(content,"This is a test file.💋")
  }

  Augur.it("should write file"){
    var name = "./newfile.txt"
    var content = "This is the 💩"
    File.write(name, content)
    var read = File.read(name)
    Assert.equal(read, content)
    File.delete(name)
  }

  Augur.it("should write buffer"){
    var name = "./newfile.bin"
    var buffer = Buffer.new(4)
    buffer.writeUint32(0, 0xFFFFFFFF)
    File.writeBuffer(name, buffer)
    var inputBuffer = File.readBuffer(name)
    // Right now we read an extra byte for zero termination
    Assert.equal(inputBuffer.size, 5)
    var value = inputBuffer.readUint32(0)
    Assert.equal(value, 0xFFFFFFFF)
  }

}

Augur.run()