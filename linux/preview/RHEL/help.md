% IMAGE_NAME(1)
% MAINTAINER
% DATE

# DESCRIPTION
Describe in greater detail the role or purpose of the image.  This can include more specifics about the
packages that make up the image.  You can also describe whether image is meant to be interactive
or more service oriented.

# USAGE
Describe how to run the image as a container and what factors might influence the behaviour of the image
itself. For example:

To set up the host system for use by the XYZ container, run:

  atomic install XYZimage

To run the XYZ container (after it is installed), run:

  atomic run XYZimage

To remove the XYZ container (not the image) from your system, run:

  atomic uninstall XYZimage

To upgrade the XYZ container from your system, run:

  atomic upgrade XYZimage

# LABELS
Describe LABEL settings (from the Dockerfile that created the image) that contains pertinent information.
For containers run by atomic, that could include INSTALL, RUN, UNINSTALL, and UPDATE LABELS. Others could
include BZComponent, Name, Version, Release, and Architecture.

# SECURITY IMPLICATIONS
If you expose ports or run with privileges, it would be warranted to briefly note those and provide
an explanation if needed.

# HISTORY
Similar to a Changelog of sorts which can be as detailed as the maintainer wishes.