# ytget
A simple script that takes a list of URLs in a text file and downloads them using youtube-dl

When the script runs, it looks for a file called queue.txt in the current directory. It will
then use youtube-dl from http://youtube-dl.org/ to download the videos in the queue.txt file
and move queue.txt into ytget's directory and rename it to .prev_queue1.txt. The last few
downloaded queues are kept.

The idea is you paste YouTube URLs into queue.txt and kick off the script, and when it finishes
it leaves a blank queue.txt. If you want to add URLs, you can put them in a file called
nextqueue.txt and the script will rename it to queue.txt and start on it when it's ready.

YouTube username and password can be entered in the ytget.conf. This will allow the script to
mark downloaded YouTube videos as watched, which will prevent YouTube's list of recommended
videos from filling up with videos you've already downloaded.
