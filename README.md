# simplex

Let's simplify our relationship with social media by going from duplex to simplex.

This tool allows broadcasting a message on Twitter, Bluesky, Mastodon and LinkedIn with a single command.

Depends on `t`, `toot`, `bksy` and `linkedin-cli`. It's on you to procure those clients and perform the initial authentication process.

The shell script in this repository is very simple, so you can easily comment out or add new clients based on your needs.

## Usage
- Follow the login procedure on each of the clients.
- Run `post.sh`, it will open your default editor (like `git commit` does). 
- Write your message, save the file, close the editor.
   - If your file is not saved or left empty, the operation will be aborted.
- Your message will be sent on all platforms, assuming everything goes well with the relative client.

### Sending images
To add images to a post: `./post.sh img1.png imgN.png`. 
The social media sites currently supported allow up to 4 images.

NOTE: sending a image post will skip LinkedIn as the relative client doesn't support images yet.

# Social Media

Thanks to this little tool you can find me at:

- https://twitter.com/croloris
- https://hachyderm.io/@kristoff
- https://bsky.app/profile/kristoff.it
- https://www.linkedin.com/in/loris-cro-99708a19a/