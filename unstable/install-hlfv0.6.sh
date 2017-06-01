(cat > composer.sh; chmod +x composer.sh; exec bash composer.sh)
#!/bin/bash
set -ev

# Get the current directory.
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Get the full path to this script.
SOURCE="${DIR}/composer.sh"

# Create a work directory for extracting files into.
WORKDIR="$(pwd)/composer-data"
rm -rf "${WORKDIR}" && mkdir -p "${WORKDIR}"
cd "${WORKDIR}"

# Find the PAYLOAD: marker in this script.
PAYLOAD_LINE=$(grep -a -n '^PAYLOAD:$' "${SOURCE}" | cut -d ':' -f 1)
echo PAYLOAD_LINE=${PAYLOAD_LINE}

# Find and extract the payload in this script.
PAYLOAD_START=$((PAYLOAD_LINE + 1))
echo PAYLOAD_START=${PAYLOAD_START}
tail -n +${PAYLOAD_START} "${SOURCE}" | tar -xzf -

# Pull the latest Docker images from Docker Hub.
docker-compose pull
docker pull hyperledger/fabric-baseimage:x86_64-0.1.0
docker tag hyperledger/fabric-baseimage:x86_64-0.1.0 hyperledger/fabric-baseimage:latest

# Kill and remove any running Docker containers.
docker-compose -p composer kill
docker-compose -p composer down --remove-orphans

# Kill any other Docker containers.
docker ps -aq | xargs docker rm -f

# Start all Docker containers.
docker-compose -p composer up -d

# Wait for the Docker containers to start and initialize.
sleep 10

# Open the playground in a web browser.
case "$(uname)" in 
"Darwin")   open http://localhost:8080
            ;;
"Linux")    if [ -n "$BROWSER" ] ; then
	       	        $BROWSER http://localhost:8080
	        elif    which xdg-open > /dev/null ; then
	                 xdg-open http://localhost:8080
	        elif  	which gnome-open > /dev/null ; then
	                gnome-open http://localhost:8080
                       #elif other types bla bla
	        else   
		            echo "Could not detect web browser to use - please launch Composer Playground URL using your chosen browser ie: <browser executable name> http://localhost:8080 or set your BROWSER variable to the browser launcher in your PATH"
	        fi
            ;;
*)          echo "Playground not launched - this OS is currently not supported "
            ;;
esac

# Exit; this is required as the payload immediately follows.
exit 0
PAYLOAD:
� 6"0Y �[o�0�yx�� �21�BJѸ)	l}�B�Gnr.-���g��U�6M�O"�s�v��96�om�[��!j�\���@J��bw��w�$I�"J�؂M(��
["�T |�P��ad *1�׽��OI	��ɠڬ^��$�B�|������bo `�\#lv"�׈�`��Q>]w�N���XJ0zLG>�� ���l�dv��6�%������(�(�E��e�����)���Xt#�TF��5=[�DK�I _�9@��)ZȢ���Md61ok2[3o��M��J�3U1抢��@U4���gEW��q��rB1��FS�{�I!1�@bO�����-?h<Gӡ1V�ʸ;PnÒϏ]������Ph�,�n�⬆g��[�c��FhJ����b?�I��xL��02
�;��WUѻ������oq��S���m�!rݖ��p���Bh�ˀ���C&z��wbef++�|���s����_�z���5�c�.m�kxev��-0���Ŗ4p6��4Z��lz;������� U��<dE����;(��9�l��Z�P�g��ڏ��S��B���}�	�����^Q�~�s�vK��"��a��g�qȸE�M��M',N������]�c6ݚ��'_���R~;��TԢ��q�J�RY���}1q��4����r���9��|��{&1o*�i�8-�ט<J�Ň�#�T�������W9���p8���p8���p8�����3_u (  