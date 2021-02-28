import React, { useState } from 'react'
import classnames from 'classnames'

export default function (props) {
  const [userInput, setUserInput] = useState('abc');

  const handleSubmit = e => {
    const text = e.target.value.trim()
    if (e.which === 13) {
      props.onSave(text)
      if (props.newTodo) {
        setUserInput('')
      }
    }
  }

  const handleChange = e => {
    setUserInput(e.target.value)
  }

  const handleBlur = e => {
    if (!props.newTodo) {
      props.onSave(e.target.value)
    }
  }

  return (
    <input className={
      classnames({
        edit: props.editing,
        'new-todo': props.newTodo
      })}
      type="text"
      placeholder={props.placeholder}
      autoFocus={true}
      value={userInput}
      onBlur={handleBlur}
      onChange={handleChange}
      onKeyDown={handleSubmit} />
  )
}
