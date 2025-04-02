---@class Node
---@field value any
---@field next Node | nil
local Node = {}
Node.__index = Node

---@param value any
---@param next? Node | nil
---@return Node
function Node:new(value, next)
  return setmetatable({
    value = value,
    next = next,
  }, self)
end

---@class CircularLinkedList
---@field private _size number
---@field private _tail Node
local CircularLinkedList = {}
CircularLinkedList.__index = CircularLinkedList

---@return CircularLinkedList
function CircularLinkedList:new()
  local t = {
    _size = 0,
    _tail = nil,
  }
  return setmetatable(t, self)
end

---@private
---@param value any
---@return Node
function CircularLinkedList:_addToEmpty(value)
  local node = Node:new(value)
  self._tail = node
  node.next = self._tail
  self._tail = node.next
  return self._tail
end

---@return Node | nil
function CircularLinkedList:tail()
  return self._tail
end

---@return Node | nil
function CircularLinkedList:head()
  return self._tail and self._tail.next
end

---@return number
function CircularLinkedList:size()
  return self._size
end

---@return boolean
function CircularLinkedList:isEmpty()
  return self._size == 0
end

---Inserts new node at the end of the list.
---@param value any
---@return Node
function CircularLinkedList:append(value)
  local node = Node:new(value)
  if self:isEmpty() then
    node = self:_addToEmpty(value)
    self._tail = node.next -- TODO need?
  else
    node.next = self._tail.next
    self._tail.next = node
    self._tail = node
  end
  self._size = self._size + 1
  return node
end

---Inserts new node at the front of the list.
---@param value any
---@return Node
function CircularLinkedList:prepend(value)
  local node = Node:new(value)
  if self:isEmpty() then
    node = self:_addToEmpty(value)
    self._tail = node -- TODO need?
  else
    node.next = self._tail.next
    self._tail.next = node
  end
  self._size = self._size + 1
  return node
end

---Inserts a new node with value after given node. If after node is nil,
---then one node inserted and pointing to itself.
---@param value any
---@param after Node | nil
---@return Node | nil
function CircularLinkedList:insertAfter(value, after)
  local node = Node:new(value)
  if after == nil then
    node = self:_addToEmpty(value)
  else
    node.next = after.next
    after.next = node
  end
  self._size = self._size + 1
  return node
end

---Inserts a new node with value before given node. If before node is nil,
---then one node inserted and pointing to itself.
---@param value any
---@param before Node | nil
---@return Node
function CircularLinkedList:insertBefore(value, before)
  local node = Node:new(value)
  if before == nil then
    node = self:_addToEmpty(value)
  else
    node = Node:new(before.value, before.next)
    before.value = value
    before.next = node
  end
  self._size = self._size + 1
  return node
end

---Removes and returns a node after given node. If given node not found nil is
---returned.
---@return any
function CircularLinkedList:removeNode(node)
  if node and not self:isEmpty() then
    node.value = node.next.value
    node.next = node.next.next
  end
  return node
end

---Removes and returns a node after found node with gven value. If given
---node not found nil is
---returned.
---@return any
function CircularLinkedList:removeByValue(value)
  local node = self:findByValue(value)
  if node then
    self:removeNode(node)
  end
  return node
end

---Checks if the list contins a give value.
---@param value any
---@return boolean
function CircularLinkedList:contains(value)
  return self:findByValue(value) ~= nil
end

---Finds the first occurrence of the value. Returns nil if not found.
---@param value any
---@return Node | nil
function CircularLinkedList:findByValue(value)
  local node = self._tail
  if not node then
    return nil
  end
  repeat
    if node.value == value then
      return node
    end
    node = node.next
  until node == self._tail
  return nil
end

---Traversal of a linked list.
---@param fn fun(node: Node|nil)
function CircularLinkedList:traverse(fn)
  local node = self._tail and self._tail.next
  if not node then
    return
  end
  repeat
    fn(node)
    node = node.next
  until node == self._tail.next
end

---@param sep? string
---@return string
function CircularLinkedList:toString(sep)
  sep = sep or " <=> "
  local t = {}
  self:traverse(function(node)
    if node then
      t[#t + 1] = tostring(node.value)
    end
  end)
  return table.concat(t, sep)
end

return CircularLinkedList
