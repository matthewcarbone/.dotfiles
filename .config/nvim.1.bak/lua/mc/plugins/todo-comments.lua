local setup, todo_comments = pcall(require, "todo-comments")

if not setup then
    print("ERROR todo-comments")
    return
end

todo_comments.setup()
