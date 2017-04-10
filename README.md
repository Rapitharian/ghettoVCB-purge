# ghettoVCB-purge.sh
This script is intended to be a helper script for ghettoVCB by William Lam.  This script seeks to solve issues with very slow NAS/NFS devices.  Example: Drobo 5n. This script moves the deletion process outside of ghettoVCB.sh in an attempt to deal with issues unique to very slow inexpensive NAS devices.  Some of these devices take longer to delete large files, 30+ GB, then the native timeouts in ghettoVCB.sh.  This seeks a solution that does not break the upgrade path of ghettoVCB.sh.

Current version of this script is V0.4.  The script is currently considered beta code by the author.

Below is a list of features I seek to add in the future.  Some help diagnose performance of the script.  Others make get the script ready for use in production enviroments.

Enhancement List:
  Merge the NFS wait/IO fix written into ghettoVCB.sh in 2012, but never released to the public, into this script.
  Add Start time tracking
  Add End time tracking
  Add logging feature
  Add email of log feature
  Add the proper sanity checks
  Add feature to pass options/switches
  Add usage notes


Licensing model yet to be determined.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
