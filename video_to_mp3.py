import os
from subprocess import call, Popen

for files in os.listdir("."):
    if files.endswith(".webm"):
        if not os.path.isfile(files.replace(".webm",".mp3")):
            print "Processing {0} ...".format(files)
            i = 0
            while os.path.isfile(files.replace(".webm",".temp{0}.ogg".format(i))):
                i += 1
            audio_extract = call(["avconv",
            	"-i","{0}/{1}".format(os.getcwd(),files),
            	"-vn",
            	"-ar","44100",
            	"-ac","2",
            	"-ab", "320",
            	"-metadata",'title={0}'.format(files.replace(".webm","")),
            	"-acodec", "libmp3lame",
            	"{0}/{1}".format(os.getcwd(),files.replace(".webm",".mp3".format(i)))
            	])