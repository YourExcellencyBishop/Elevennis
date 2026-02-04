#macro INVALID -1

#macro useDebug false
#macro Debug:useDebug true

// CreatePhysicsBodies Script
#macro alphaChannelIndex 3
#macro byteCountRGBA 4
#macro byteCountR 1

enum EDGE
{
	NONE = 0b00,
	FILLED = 0b01,
	VISITED = 0b10,
	PROCESSED = 0b11
}