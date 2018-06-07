import times, strutils, libsha/sha256, strformat

type
  Block = object
    index: int
    hash: string
    prevHash: string
    timestamp: string
    data: string

proc new(this: type Block, index: int, hash: string, prevHash: string, timestamp: string, data: string): Block =
  result.index = index
  result.hash = hash
  result.prevHash = prevHash
  result.timestamp = timestamp
  result.data = data

const genesisBlock: Block = new(
  Block, 0, "629585c9a487007bc146586b1fdf61d3116ff5dfac6d8da90059387fc89ddeb0", "", "123456", "Genesis Block"
)

let blockchain: seq[Block] = @[genesisBlock]

proc getBlockChain(): seq[Block] =
  return blockchain

proc getLatestBlock(): Block =
  return blockchain[blockchain.len - 1]

proc generateNextBlock(blockData: string): Block =
  const prevBlock: Block = getLatestBlock()
  const nextIndex: int = prevBlock.index + 1
  const nextTimestamp: string = getClockStr().replace(":", "")
  const nextHash: string = calculateHash(nextIndex, nextHash, prevBlock.hash, nextTimestamp, blockData)
  const newBlock: Block = new Block(nextIndex, nextHash, prevBlock.hash, nextTimestamp, blockData)
  addBlock(newBlock)
  return newBlock;

# hashing

proc calculateHash(index: int, prevHash: string, timestamp: string, data: string): string =
  return sha256hexdigest($index & prevHash & timestamp & data)

proc calculateHashForBlock(blk: Block): string =
  return calculateHash(blk.index, blk.prevHash, blk.timestamp, blk.data)

proc addBlock(newBlock: Block) =
  if isNewBlockValid(newBlock, getLatestBlock()):
    blockchain.add(newBlock)

proc checkBlockStructure(blk: Block): bool =
  if blk.index.type.name == "int" and
    blk.timestamp.type.name == "string" and
    blk.hash.type.name == "string" and
    blk.prevHash.type.name == "string" and
    blk.data.type.name == "string":
     return true
  else:
    return false

proc isNewBlockValid(newBlock: Block, prevBlock: Block): bool =
  if not checkBlockStructure(newBlock):
    echo "invalid structure"
    return false
  if prevBlock.index + 1 != newBlock.index:
    echo "invalid index"
    return false
  elif prevBlock.hash != newBlock.prevHash:
    echo "invalid previous hash"
  elif calculateHashForBlock(newBlock) != newBlock.hash:
    echo fmt"{newBlock.hash.type.name} {calculateHashForBlock(newBlock).type.name}"
    echo fmt"invalid hash: {calculateHashForBlock(newBlock) {newBlock.hash}}"
    return false
  return true

proc addBlockToChain(newBlock: Block): bool =
  if isNewBlockValid(newBlock, getLatestBlock()):
    blockchain.add(newBlock)
    return true

