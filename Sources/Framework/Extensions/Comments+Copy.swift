extension Comments {

    func copy(withNewComment newComment: [Comment]) -> Comments {
        return Comments(comments: newComment, nextPosition: nextPosition, debateClosed: debateClosed)
    }

}
