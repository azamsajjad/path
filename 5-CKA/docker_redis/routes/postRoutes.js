const express = require("express")

const postController = require("../controllers/postController")

const router = express.Router()

//localhost:3000/api/v1/post => //localhost:3000/ or //localhost:3000/:id
router
    .route("/")
    .get(postController.getAllPosts)
    .post(postController.createPost);

router
    .route("/:id")
    .get(postController.getOnePost)
    .patch(postController.updatePost)
    .delete(postController.deletePost);

module.exports = router;
